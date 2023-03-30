{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{
    config(
        cluster_by="_airbyte_emitted_at",
        partition_by={
            "field": "_airbyte_emitted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_sms_opt_ins_hashid",
    )
}}

-- depends_on: {{ source('cta', 'sms_opt_ins_base') }}
select
    _airbyte_sms_opt_ins_hashid,
    max(id) as id,
    max(user_id) as user_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(organization_id) as organization_id,
    max(sms_opt_in_status) as sms_opt_in_status,
    max(user__phone_number) as user__phone_number,
    max(_airbyte_ab_id) as _airbyte_ab_id,
    max(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ source("cta", "sms_opt_ins_base") }}
group by _airbyte_sms_opt_ins_hashid
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
