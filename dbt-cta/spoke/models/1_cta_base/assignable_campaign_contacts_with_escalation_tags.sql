select * from {{ source('cta','assignable_campaign_contacts_with_escalation_tags_raw') }}_base
