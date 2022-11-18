//import logo from './logo.svg';
//import './App.css';
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Profile from "./routes/Profile";
import Timetable from "./routes/Timetable";
import Information from "./routes/Information";
import Home from "./routes/Home";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/user" element={<Profile />} />
        <Route path="/timetable" element={<Timetable />} />
        <Route path="/information" element={<Information />} />
        <Route exact path="/" element={<Home />} />
      </Routes>
    </Router>
  );
}

export default App;
