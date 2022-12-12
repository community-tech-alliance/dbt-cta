-- Final base SQL model
-- depends_on: {{ ref('company_base') }}
select
    id as company_id,
    domain
from {{ ref('company_base') }} companies, UNNEST(companies.domains) as domain
-- companies from {{ source('cta', 'company_base') }}


