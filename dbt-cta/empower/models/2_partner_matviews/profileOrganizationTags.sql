select
    profileEid,
    tagId,
from {{ ref('profileOrganizationTags_base') }}