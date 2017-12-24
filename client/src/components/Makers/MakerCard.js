import React from 'react';
import { Card, Icon, Avatar } from 'antd';
// import { routerRedux } from 'dva/router';

// const { Meta } = Card;

function MakerCard({ maker }) {
  return (
    <Card>
      <Card.Meta
        avatar={<Avatar src={maker.logo} />}
        title={maker.name}
        description={maker.description}
      />
    </Card>
  );
}

function mapStateToProps(state) {
  const { data, page } = state.makers;
  return {
    // loading: state.loading.models.Makers,
    data,
    page,
  };
}

export default connect(mapStateToProps)(Makers);
