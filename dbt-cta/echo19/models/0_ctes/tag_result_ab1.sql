-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_tag_result') }}

select
    tagResultId,
    tagId,
    scheduleId,
    programId,
    name,
    contactId,
    isOptOut,
    dateCreated,
   {{ dbt_utils.surrogate_key([
     'tagResultId',
    'tagId',
    'scheduleId',
    'programId',
    'name',
    'contactId',
    'isOptOut',
    'dateCreated'
    ]) }} as tag_result_hashid
from {{ source('cta', '_stg_tag_result') }}
