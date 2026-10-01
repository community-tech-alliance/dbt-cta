-- ensures the base model contains only one row per Lineitem_ID
-- this deduplicates data even if the source data contains duplicate rows
--
-- Partitions on the business key rather than the row hash. The Airbyte source
-- syncs incrementally with a 14 day lookback, so raw holds several versions of a
-- recently disbursed contribution -- identical except for Disbursement_ID/Date.
-- Those differ by hash, so a hash partition would emit all of them and the
-- merge on Lineitem_ID in the base model would fail with "UPDATE/MERGE must
-- match at most one source row for each target row". Newest extract wins.

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by Lineitem_ID order by _airbyte_extracted_at desc) as rownum
        from {{ ref('managed_form_contributions_stream_ab3') }}
    )
where rownum = 1
