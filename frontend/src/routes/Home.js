import icon from "./1.png";
import styles from "./Home.module.css";
import { Link } from "react-router-dom";

function Home() {
  return (
    <div>
      <div className={styles.container_main}>
        <div className={styles.container}>
          <img
            className={styles.img}
            src="http://www2.facdent.hku.hk/images/faclogoonly.png"
          ></img>
          <h3 className={styles.hku}>H K U x I C M S</h3>
        </div>
        <div className={styles.container_button}>
          <Link to={`/user`}>
            <button className={styles.button}>Log In</button>
          </Link>
        </div>
      </div>
    </div>
  );
}

export default Home;
