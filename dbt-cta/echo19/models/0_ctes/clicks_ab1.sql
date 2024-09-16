-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_clicks') }}

select
    clickId,
    scheduleId,
    programId,
    contactId,
    dateCreated,
    ipAddress,
    longUrl,
   {{ dbt_utils.surrogate_key([
    'clickId',
    'scheduleId',
    'programId',
    'contactId',
    'dateCreated',
    'ipAddress',
    'longUrl',
    ]) }} as clicks_hashid
from {{ source('cta', '_stg_clicks') }}
