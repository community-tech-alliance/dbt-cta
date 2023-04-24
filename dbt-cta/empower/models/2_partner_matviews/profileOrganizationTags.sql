select
    profileEid,
    tagId,
from {{ source('cta','profileOrganizationTags_base') }}