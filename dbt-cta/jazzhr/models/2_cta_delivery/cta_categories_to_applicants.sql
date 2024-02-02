select
    category_id,
    applicant_id,
    id,
    _airbyte_emitted_at,
    _airbyte_categories_to_applicants_hashid
from {{ source('cta','categories_to_applicants_base') }}