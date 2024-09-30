select

Fee,
Date,
Amount,
Mobile

from {{ source("cta", "refunded_contributions_base") }}
