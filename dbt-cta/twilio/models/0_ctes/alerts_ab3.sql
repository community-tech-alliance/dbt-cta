{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'sid',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('alerts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'url',
        'log_level',
        'more_info',
        'alert_text',
        'error_code',
        'account_sid',
        'api_version',
        'request_url',
        'service_sid',
        'date_created',
        'date_updated',
        'resource_sid',
        'date_generated',
        'request_method',
    ]) }} as _airbyte_alerts_hashid,
    tmp.*
from {{ ref('alerts_ab2') }} tmp
-- alerts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

