<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Home</h1>
	<script>
		function send(message) {
			conn.send(JSON.stringify(message));
		}
		var conn = new WebSocket('ws://localhost:8080/webrtc/socket');
		var peerConnection = new RTCPeerConnection(null, {
			optional : [ {
				RtpDataChannels : true
			} ]
		});
		var dataChannel = peerConnection.createDataChannel("dataChannel", {
			reliable : true
		});
		conn.onopen = function() {
			
			dataChannel.onerror = function(error) {
				console.log("Error:", error);
			};
			dataChannel.onclose = function() {
				console.log("Data channel is closed");
			};
			dataChannel.onopen = function(){
				console.log("Data channel is open");
				dataChannel.send("connected");
			}
			peerConnection.createOffer(function(offer) {
				send({
					event : "offer",
					data : offer
				});
				peerConnection.setLocalDescription(offer);
			}, function(error) {
				console.log("Error:", error);
			});
			peerConnection.onicecandidate = function(event) {
			    if (event.candidate) {
			        send({
			            event : "candidate",
			            data : event.candidate
			        });
			    }
			};
		}
		conn.onmessage = function(event) {
			var data = JSON.parse(event.data);
			console.log("onmessage : " + data.event);
			
			switch(data.event){
			case "answer":
				console.log(new RTCSessionDescription(data.data));
				peerConnection.setRemoteDescription(new RTCSessionDescription(data.data));
				break;
			}
		}
	</script>
</body>
</html>