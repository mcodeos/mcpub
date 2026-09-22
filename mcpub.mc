# Copyright 2026 MCode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

// Real market-part samples (random selection). Vendor part numbers and
// manufacturer identity allowed here. Parts may be defined standalone or
// based on an mclibs abstract component; the dependency direction
// mcpub -> mclibs -> mcode is one-way.

// import modules
pub use ./clock/mcp7940m.mc
pub use ./comm/pl3085a.mc
pub use ./connector/lp3220.mc
pub use ./connector/usb_mini_socket.mc
pub use ./digital/sn74lvc1g175.mc
pub use ./expand/pca9555.mc
pub use ./isolation/nsi814x.mc
pub use ./mcu/tc275.mc
pub use ./passive/bss138n.mc
pub use ./power/ams1117.mc
pub use ./power/tle7368.mc
