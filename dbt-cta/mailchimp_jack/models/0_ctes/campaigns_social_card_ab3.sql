{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_social_card_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'title',
        'image_url',
        'description',
    ]) }} as _airbyte_social_card_hashid,
    tmp.*
from {{ ref('campaigns_social_card_ab2') }} tmp
-- social_card at campaigns/social_card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

