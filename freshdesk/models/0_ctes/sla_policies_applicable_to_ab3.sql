{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_applicable_to_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sla_policies_hashid',
        array_to_string('sources'),
        array_to_string('group_ids'),
        array_to_string('company_ids'),
        array_to_string('product_ids'),
        array_to_string('ticket_types'),
    ]) }} as _airbyte_applicable_to_hashid,
    tmp.*
from {{ ref('sla_policies_applicable_to_ab2') }} tmp
-- applicable_to at sla_policies/applicable_to
where 1 = 1

