import nav from "./Nav.module.css";
import { Link } from "react-router-dom";
import icon from "./3.png";

function Nav() {
  return (
    <div className={nav.box}>
      <div className={nav.column}>
        <div className={nav.home}>
          <img
            className={nav.img}
            src="http://www2.facdent.hku.hk/images/faclogoonly.png"
          ></img>
          <h3 className={nav.hku}>H K U x I C M S</h3>
        </div>
      </div>
      <div className={nav.column}></div>
      <div className={nav.column}></div>
    </div>
  );
}

export default Nav;
