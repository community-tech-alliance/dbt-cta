select
    _airbyte_extracted_at,
    profileEid,
    tagId,
    _airbyte_profileOrganizationTags_hashid
from {{ source('cta','profileOrganizationTags_base') }}
