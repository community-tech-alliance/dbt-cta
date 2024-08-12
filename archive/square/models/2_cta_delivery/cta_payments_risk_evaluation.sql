select *
from {{ source('cta','payments_risk_evaluation_base') }}
