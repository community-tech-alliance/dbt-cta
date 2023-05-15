select
    _airbyte_emitted_at,
    organizationId,
    inviteCodeCreatedMts,
    ctaId,
    inviteCode,
    name,
    description,
    id,
    _airbyte_regions_hashid
from {{ source('cta','regions_base') }}