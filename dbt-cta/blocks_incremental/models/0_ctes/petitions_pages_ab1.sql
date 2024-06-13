
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'petitions_pages') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   date,
   notes,
   county,
   extras,
   number,
   shift_id,
   notary_id,
   packet_id,
   box_number,
   created_at,
   updated_at,
   notary_date,
   notary_seal,
   scan_number,
   canvasser_id,
   notary_county,
   possible_fraud,
   scan_file_data,
   signers_county,
   notary_signature,
   petition_book_id,
   signatures_count,
   created_by_user_id,
   canvasser_signature,
   {{ dbt_utils.surrogate_key([
     'id',
    'date',
    'notes',
    'county',
    'extras',
    'number',
    'shift_id',
    'notary_id',
    'packet_id',
    'box_number',
    'notary_date',
    'notary_seal',
    'scan_number',
    'canvasser_id',
    'notary_county',
    'possible_fraud',
    'scan_file_data',
    'signers_county',
    'notary_signature',
    'petition_book_id',
    'signatures_count',
    'created_by_user_id',
    'canvasser_signature'
    ]) }} as _airbyte_petitions_pages_hashid
from {{ source('cta', 'petitions_pages') }}