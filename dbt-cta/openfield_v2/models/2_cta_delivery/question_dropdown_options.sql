select *
from {{ source('cta', 'question_dropdown_options_base') }}
