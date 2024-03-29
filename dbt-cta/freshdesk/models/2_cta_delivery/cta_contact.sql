-- Final base SQL model
-- depends_on: {{ ref('contact_base') }}
select
  _airbyte_emitted_at,
    id,
    company_id,
    active,
    address,
    description,
    email,
    job_title,
    language,
    mobile,
    name,
    phone,
    time_zone,
    twitter_id,
    created_at,
    updated_at,
    custom_affiliate_organization
from {{ source('cta', 'contact_base') }}
-- companies from {{ source('cta', 'contact_base') }}


