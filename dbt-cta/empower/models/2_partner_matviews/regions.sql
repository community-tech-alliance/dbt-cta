select
    organizationId,
    inviteCodeCreatedMts,
    ctaId,
    inviteCode,
    name,
    description,
    id,
from {{ source('cta','regions_base') }}