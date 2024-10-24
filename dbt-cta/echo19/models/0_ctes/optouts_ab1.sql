-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_optouts') }}

select
    clientId,
    clientName,
    phoneNumber,
    optOutId,
   {{ dbt_utils.surrogate_key([
    'clientId',
    'clientName',
    'phoneNumber',
    'optOutId'
    ]) }} as optouts_hashid
from {{ source('cta', '_stg_optouts') }}
