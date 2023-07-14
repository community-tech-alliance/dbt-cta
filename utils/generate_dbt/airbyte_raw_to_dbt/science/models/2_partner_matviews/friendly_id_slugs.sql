
{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    sluggable_type,
    sluggable_id,
    scope,
    created_at,
    id,
    slug,
    _airbyte_friendly_id_slugs_hashid,
    _airbyte_ab_id,
    _airbyte_emitted_at
FROM {{ source('cta', 'friendly_id_slugs_base') }}