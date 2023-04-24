select
    organizationId,
    inviteCodeCreatedMts,
    ctaId,
    inviteCode,
    name,
    description,
    id,
from {{ ref('regions_base') }}