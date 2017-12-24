// export default connect(mapStateToProps)(Makers);

// import React from 'react';
// import { connect } from 'dva';
// import styles from './Makers.css';
// import MainLayout from '../components/Layouts/MainLayout/MainLayout';
// import MakersComponent from '../components/Makers/Makers';

// function Makers({ location }) {
//   return (
//     <MainLayout location={location}>
//       <div className={styles.normal}>
//         <MakersComponent />
//       </div>
//     </MainLayout>
//   );
// }

// export default connect()(Makers);

import React, { PureComponent } from 'react';
import { connect } from 'dva';
import styles from './Makers.css';
// import MainLayout from '../components/Layouts/MainLayout/MainLayout';
import BasicLayout from '../components/Layouts/BasicLayout';
import MakersComponent from '../components/Makers/Makers';

@connect()
export default class Makers extends PureComponent {
  // componentDidMount() {
  //   this.props.dispatch({
  //     type: 'makers/fetch',
  //   });
  // }

  render() {
    // const { makers } = this.props;

    return (
      <BasicLayout location={this.props.location}>
        <div className={styles.normal}>
          <MakersComponent />
        </div>
      </BasicLayout>
    );
  }
}
