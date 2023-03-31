{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to dedup incoming data on Receipt_ID field
-- depends_on: {{ ref('cancelled_recurring_contributions_stream_ab2') }}
select
  * except (row_num)
from (
  select
    *,
    row_number() over(partition by Receipt_ID order by Cancelled_On desc) as row_num
  from {{ ref('cancelled_recurring_contributions_stream_ab2') }}
)
where row_num = 1