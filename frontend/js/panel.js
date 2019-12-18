import css from "../css/panel.css";
import "phoenix_html";

import {Socket} from "phoenix";
import LiveSocket from "phoenix_live_view";

let liveSocket = new LiveSocket("/live", Socket);
liveSocket.connect();
