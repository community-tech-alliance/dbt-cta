SELECT * FROM {{ source('cta', 'sla_policy_base') }}  _airbyte_emitted_at,
