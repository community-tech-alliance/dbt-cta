select *
from {{ source('cta', 'dashboard_widgets_base') }}
