{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_ab4') }}
select
    CurrencyRef,
    FamilyName,
    FullyQualifiedName,
    GivenName,
    CompanyName,
    ShipAddr,
    MetaData,
    PaymentMethodRef,
    BillWithParent,
    DisplayName,
    PreferredDeliveryMethod,
    ResaleNum,
    Job,
    PrimaryEmailAddr,
    WebAddr,
    BillAddr,
    PrimaryPhone,
    PrintOnCheckName,
    airbyte_cursor,
    MiddleName,
    Mobile,
    ParentRef,
    SyncToken,
    Active,
    sparse,
    domain,
    BalanceWithJobs,
    DefaultTaxCodeRef,
    Level,
    SalesTermRef,
    Id,
    Fax,
    Balance,
    Taxable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customers_hashid
from {{ ref('customers_ab4') }}
-- customers from {{ source('cta', '_airbyte_raw_customers') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}