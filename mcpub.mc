# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real market-part samples (random selection). Vendor part numbers and
// manufacturer identity allowed here. Parts may be defined standalone or
// based on an mclibs abstract component; the dependency direction
// mcpub -> mclibs -> mcode is one-way.

// The library is installed whole (cp.sh copies it into ~/.mcode) but
// consumed per part file: a project references exactly the sample it
// needs, e.g. `use mcpub.mcu/tc275/tc275.mc`. Each part lives in its own
// directory next to its original datasheet (PDF and pdftotext cache).
// Unlike mclibs/mcode there is
// no aggregate import -- loading this entry file registers nothing by
// design; do not turn it into a full manifest.
