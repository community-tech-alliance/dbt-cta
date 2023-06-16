{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='quality_control_flags_voter_registration_scans_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('quality_control_flags_voter_registration_scans_ab3') }}
select
    voter_registration_scan_id,
    quality_control_flag_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quality_control_flags_voter_registration_scans_hashid
from {{ ref('quality_control_flags_voter_registration_scans_ab3') }}
-- quality_control_flags_voter_registration_scans from {{ source('sv_blocks', '_airbyte_raw_quality_control_flags_voter_registration_scans') }}
where 1 = 1

