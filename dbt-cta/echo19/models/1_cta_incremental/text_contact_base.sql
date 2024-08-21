{{ config(
    unique_key = "textResultId"
) }}

-- Final base SQL model
-- depends_on: {{ ref('text_contact_ab2') }}
select

    textResultId,
    scheduleId,
    programId,
    programName,
    scheduleName,
    cast(t.from as string) as `from`,
    cast(t.to as string) as `to`,
    direction,
    message,
    isMMS,
    segments,
    threadId,
    disposition,
    error,
    dateCreated,
    callerIdPhoneNumberId,
    cost,
    contactId,
    externalId,
    contactFirstName,
    contactLastName,
    contactAge,
    contactGender,
    contactRace,
    contactExtra1,
    contactExtra2,
    contactExtra3,
    contactExtra4,
    contactExtra5,
    contactExtra6,
    contactExtra7,
    contactExtra8,
    contactExtra9,
    contactExtra10,
    contactExtra11,
    contactExtra12,
    contactExtra13,
    contactExtra14,
    contactExtra15,
    contactExtra16,
    contactExtra17,
    contactExtra18,
    contactExtra19,
    contactExtra20,
    contactExtra21,
    contactExtra22,
    contactExtra23,
    contactExtra24,
    contactExtra25,
    contactExtra26,
    contactExtra27,
    contactExtra28,
    contactExtra29,
    contactExtra30,
    text_contact_hashid
from {{ ref('text_contact_ab2') }} as t
