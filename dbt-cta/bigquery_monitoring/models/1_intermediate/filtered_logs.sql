select 1 as colname
 *
from {{ source('cta','cloudaudit_googleapis_com_data_access') }}
where resource.labels.project_id = '{{ env_var("PARTNER_PROJECT_ID") }}'