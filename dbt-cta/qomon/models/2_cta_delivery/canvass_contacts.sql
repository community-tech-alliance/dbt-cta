-- One row per contact with at least one completed field interaction: IDs, contact details,
-- address, latest canvass, current support level and latest answer to every survey question.
-- Ported from Qomon's canvass_flat query. Custom fields and survey answers are arrays keyed by the
-- question label rather than one column per question, since questions differ by Qomon group and change.

with canvassed as (
    select
        fact_contacts.contact_id,
        count(distinct facts.id) as canvass_count,
        max(facts.updated_at) as last_canvass_at,
        array_agg(
            struct(
                coalesce(actions.name, facts.type) as action_name,
                nullif(trim(concat(coalesce(users.firstname, ''), ' ', coalesce(users.surname, ''))), '') as canvasser_name,
                users.email as canvasser_email
            )
            order by facts.updated_at desc
            limit 1
        )[offset(0)] as last_canvass
    from {{ source('cta', 'facts_base') }} as facts
    inner join {{ source('cta', 'fact_contacts_base') }} as fact_contacts
        on fact_contacts.fact_id = facts.id
    left join {{ source('cta', 'action_facts_base') }} as action_facts
        on action_facts.fact_id = facts.id
    left join {{ source('cta', 'actions_base') }} as actions
        on actions.id = action_facts.action_id
    left join {{ source('cta', 'users_base') }} as users
        on users.id = facts.user_id
    where facts.deleted_at is null
        and facts.status = 'done'
    group by fact_contacts.contact_id
),

-- Latest value of each custom field, with the option label for closed questions
latest_custom_fields as (
    select
        custom_fields.contact_id,
        forms.label as field,
        forms.`order` as field_order,
        coalesce(nullif(refvalues.label, ''), custom_fields.data) as value
    from {{ source('cta', 'custom_fields_base') }} as custom_fields
    inner join canvassed
        on canvassed.contact_id = custom_fields.contact_id
    inner join {{ source('cta', 'forms_base') }} as forms
        on forms.id = custom_fields.form_id
    left join {{ source('cta', 'refvalues_base') }} as refvalues
        on refvalues.id = custom_fields.form_ref_id
    where custom_fields.deleted_at is null
    qualify row_number() over (
        partition by custom_fields.contact_id, custom_fields.form_id
        order by custom_fields.date desc, custom_fields.updated_at desc
    ) = 1
),

custom_field_values as (
    select
        contact_id,
        array_agg(struct(field, value) order by field_order, field) as custom_fields
    from latest_custom_fields
    group by contact_id
),

-- Every answer from the latest collection of each question. Checkbox questions have one row per selected option.
latest_answers as (
    select
        formdata.contact_id,
        formdata.form_id,
        forms.name as form_family,
        forms.label as question,
        forms.`order` as question_order,
        coalesce(nullif(refvalues.label, ''), formdata.data) as answer,
        formdata.date as answered_at
    from {{ source('cta', 'formdata_base') }} as formdata
    inner join canvassed
        on canvassed.contact_id = formdata.contact_id
    inner join {{ source('cta', 'forms_base') }} as forms
        on forms.id = formdata.form_id
    left join {{ source('cta', 'refvalues_base') }} as refvalues
        on refvalues.id = formdata.form_ref_id
    where formdata.deleted_at is null
        and forms.name in ('FORM', 'STATUS', 'CONSENT', 'name_presence')
    qualify formdata.date is not distinct from max(formdata.date) over (partition by formdata.contact_id, formdata.form_id)
),

answers_by_question as (
    select
        contact_id,
        form_id,
        any_value(form_family) as form_family,
        any_value(question) as question,
        any_value(question_order) as question_order,
        string_agg(answer, '; ' order by answer) as answer,
        max(answered_at) as answered_at
    from latest_answers
    group by contact_id, form_id
),

answers as (
    select
        contact_id,
        max(if(form_family = 'STATUS', answer, null)) as support_level,
        max(if(form_family = 'STATUS', answered_at, null)) as support_level_at,
        max(if(form_family = 'CONSENT', answer, null)) as consent,
        max(if(form_family = 'name_presence', answer, null)) as presence,
        array_agg(
            if(form_family = 'FORM', struct(question, answer, answered_at), null)
            ignore nulls
            order by question_order, question
        ) as survey_answers
    from answers_by_question
    group by contact_id
)

select
    contacts.group_id,
    contacts.id as qomon_contact_id,
    contacts.external_id,
    contacts.firstname,
    contacts.surname,
    contacts.married_name,
    contacts.gender,
    contacts.birthdate,
    contacts.mail as email,
    contacts.phone,
    contacts.mobile,
    coalesce(contacts.black_list, false) as do_not_contact,
    addresses.house_number,
    addresses.street,
    addresses.door,
    addresses.addition as address_line_2,
    addresses.city,
    addresses.state,
    addresses.postal_code,
    addresses.county,
    addresses.polling_station,
    answers.support_level,
    answers.support_level_at,
    answers.consent,
    answers.presence,
    canvassed.canvass_count,
    canvassed.last_canvass_at,
    canvassed.last_canvass.action_name as last_canvass_action,
    canvassed.last_canvass.canvasser_name as last_canvasser,
    canvassed.last_canvass.canvasser_email as last_canvasser_email,
    custom_field_values.custom_fields,
    answers.survey_answers,
    contacts.created_at,
    contacts.updated_at,
    contacts.deleted_at
from canvassed
inner join {{ source('cta', 'contacts_base') }} as contacts
    on contacts.id = canvassed.contact_id
left join {{ source('cta', 'addresses_base') }} as addresses
    on addresses.id = contacts.address_id
left join custom_field_values
    on custom_field_values.contact_id = contacts.id
left join answers
    on answers.contact_id = contacts.id
