select *
from {{ source('cta','cloudaudit_googleapis_com_data_access') }}
where resource.labels.project_id = '{{ env_var("PARTNER_PROJECT_ID") }}'
-- filter out queries by CTA staff
and protopayload_auditlog.authenticationInfo.principalEmail not like '%techallies.org'
