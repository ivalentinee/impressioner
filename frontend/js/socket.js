import {Socket} from "phoenix";

let socket = new Socket("/socket", {params: {token: window.userToken}});
socket.connect();

let liveSocket = new LiveSocket("/live", Socket);
liveSocket.connect();


let channel = socket.channel("topic:subtopic", {});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp); })
  .receive("error", resp => { console.log("Unable to join", resp); });

export default socket;
