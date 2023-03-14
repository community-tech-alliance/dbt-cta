-- SQL model to get latest `date_updated` values for each sid
-- depends_on: {{ ref('calls_ab2') }}
select
    sid,
    max(date_updated) as date_updated
from {{ ref('calls_ab2') }} tmp
-- calls
where 1 = 1
group by sid