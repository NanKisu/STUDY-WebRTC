<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Outdoor</h1>
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
		}

		conn.onmessage = function(event) {
			var data = JSON.parse(event.data);
			console.log("onmessage : " + data.event);
			
			switch(data.event){
			case "offer":
				console.log("offer");
				peerConnection.setRemoteDescription(new RTCSessionDescription(data.data));
				peerConnection.createAnswer(function(answer) {
				    peerConnection.setLocalDescription(answer);
				        send({
				            event : "answer",
				            data : answer
				        });
				}, function(error) {
					console.log("Error:", error);
				});
				break;
			case "candidate":
				console.log("cadidate");
				peerConnection.addIceCandidate(new RTCIceCandidate(data.data));
				break;
			}
		};
		
		dataChannel.onmessage = function(event) {
		    console.log("Message:", event.data);
		};
	</script>
</body>
</html>