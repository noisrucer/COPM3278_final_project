import React, { useState, useEffect } from 'react'
import Webcam from 'react-webcam'
import axios from 'axios'
const WebcamComponent = () => <Webcam />
const videoConstraints = {
  width: 400,
  height: 400,
  facingMode: 'user',
}
const Profile = () => {
  let [picture, setPicture] = useState('')
  const webcamRef = React.useRef(null)
  const capture = React.useCallback(() => {
    //console.log('Photo Taken!') 
    const pictureSrc = webcamRef.current.getScreenshot()
    setPicture(pictureSrc)
    var today = new Date();
    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds() + ":" + today.getMilliseconds();
    console.log(time)
    sleep(500)
    var btnFaceRecognition = document.querySelector(".recognition");
    setInterval(function () {btnFaceRecognition.click();},500);

  })
  function sleep(milliseconds) {
    const date = Date.now();
    let currentDate = null;
    do {
      currentDate = Date.now();
    } while (currentDate - date < milliseconds);
  }
  
useEffect(() => {
   console.log('Post to server')
   console.log(picture)
   axios.post('http://localhost:8000/server',{name:picture}).then(res => console.log(res))
 }, [picture]);
  return (
    <div>
      <h2 className="mb-5 text-center">
        React Photo Capture using Webcam Example
      </h2>
      <div>
        
          <Webcam
            audio={false}
            height={400}
            ref={webcamRef}
            width={400}
            screenshotFormat="image/jpeg"
            videoConstraints={videoConstraints}
          />
        
      </div>
      <div>
        
          <button
            on={(e) => {
              e.preventDefault()
              axios.get('http://localhost:8000/check')
              .then(res => console.log(res))
            }}
            className="btn btn-primary"
          >
            Retake
          </button>
      
          <button
            onClick={(e) => {
              e.preventDefault()
              capture()
              e.target.style.display = 'none'
            }}
            className="recognition"
          >
            Face Recognition
          </button>
        
      </div>
    </div>
  )
}
export default Profile