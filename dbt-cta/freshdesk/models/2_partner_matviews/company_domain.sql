-- Final base SQL model
-- depends_on: {{ ref('company_base') }}
select
  _airbyte_emitted_at,
    id as company_id,
    domain
from {{ source('cta', 'company_base') }} companies, UNNEST(companies.domains) as domain
-- companies from {{ source('cta', 'company_base') }}


