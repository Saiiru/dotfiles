---
tags: [inventory, hardware]
cssclasses: [page-manila]
---

# Hardware Lab — Inventário & Setup

## Inventário (Dataview table)
```dataview
table file.link as Item, qty, location, status
from "02 - Areas/Hardware Lab"
where contains(tags, "inventory")
```

## Checklist Básica
- [ ] ESD mat
- [ ] Soldering station
- [ ] Multimeter
- [ ] Bench PSU
- [ ] Power bank / chargers
- [ ] Toolkit (pliers, cutters)

## Notes
- Safety first: always fuse and current-limit bench supplies.
- Keep small Li-ion batteries in a LiPo safe bag.
