import React, { PureComponent } from 'react';
import { connect } from 'dva';
import { List, Button, Card, Rate, Radio, Input } from 'antd';
import { routerRedux } from 'dva/router';
import queryString from 'query-string';

import FreshModal from './FreshModal';
import PageHeaderLayout from '../Layouts/PageHeaderLayout';
import Ellipsis from '../../components/Ellipsis';
import { PAGE_SIZE } from '../../constants';

import styles from './Makers.less';

const RadioButton = Radio.Button;
const RadioGroup = Radio.Group;
const Search = Input.Search;

@connect(state => ({
  loading: state.loading.models.makers,
  data: state.makers.data,
  query: state.makers.query,
  page: state.makers.page,
}))
export default class Makers extends PureComponent {
  constructor(props) {
    super(props);

    this.pageChangeHandler = this.pageChangeHandler.bind(this);
    this.rateChangeHandler = this.rateChangeHandler.bind(this);
    this.searchHandler = this.searchHandler.bind(this);
  }

  pageChangeHandler(page) {
    this.props.dispatch(
      routerRedux.push({
        pathname: '/makers',
        search: queryString.stringify({ page }),
      }),
    );
  }

  rateChangeHandler(id, value) {
    // console.log(id, value);
    this.props.dispatch({
      type: 'makers/patch',
      payload: { id, values: { maker: { rate: value } } },
    });
  }

  searchHandler(query) {
    console.log('searchHandler', query);
    this.props.dispatch({
      type: 'makers/fetch',
      payload: { query },
    });
  }

  freshHandler = () => {
    console.log('fresh');
  };

  render() {
    const { data, loading, query, page: current } = this.props;

    const extraContent = (
      <div className={styles.extraContent}>
        <FreshModal title="Fresh" onFresh={this.freshHandler}>
          Fresh
        </FreshModal>
        <RadioGroup defaultValue="all">
          <RadioButton value="all">全部</RadioButton>
          <RadioButton value="progress">进行中</RadioButton>
          <RadioButton value="waiting">等待中</RadioButton>
        </RadioGroup>
        <Search
          className={styles.extraContentSearch}
          placeholder="请输入"
          onSearch={(value) => {
            this.searchHandler(value);
          }}
          enterButton
        />
      </div>
    );

    return (
      <PageHeaderLayout title="Makers List" content={<div />} extraContent={extraContent}>
        <div className={styles.cardList}>
          <List
            rowKey="id"
            grid={{ gutter: 30, lg: 3, md: 2, sm: 1, xs: 1 }}
            loading={loading}
            dataSource={data.list}
            pagination={{
              total: data.total,
              current,
              pageSize: PAGE_SIZE,
              onChange: this.pageChangeHandler,
            }}
            renderItem={item => (
              <List.Item key={item.id}>
                <Card hoverable className={styles.card}>
                  <Card.Meta
                    avatar={
                      <img
                        alt=""
                        className={styles.cardAvatar}
                        src={`/api/assets/images/logo/${item.logo}`}
                      />
                    }
                    title={<a href="#">{item.name}</a>}
                    description={
                      <div>
                        <Ellipsis className={styles.item} lines={4}>
                          {item.description}
                        </Ellipsis>
                        <Rate
                          allowHalf
                          defaultValue={item.rate}
                          onChange={this.rateChangeHandler.bind(null, item.id)}
                        />
                      </div>
                    }
                  />
                </Card>
              </List.Item>
            )}
          />
        </div>
      </PageHeaderLayout>
    );
  }
}
