import queryString from 'query-string';
import * as makersService from '../services/makers';

export default {
  namespace: 'makers',

  state: {
    data: { total: 0, list: [] },
    query: '',
    page: 1,
  },

  reducers: {
    save(state, { payload: { data, query, page } }) {
      return { ...state, data, query, page };
    },
  },
  effects: {
    *fetch({ payload: { query = '', page = 1 } }, { call, put }) {
      console.log('*fetch', `query: <${query}>`, `page: ${page}`);
      const { data } = yield call(makersService.fetch, { query, page });
      console.log('*fetch - data', `data: <${data}>`);
      yield put({
        type: 'save',
        payload: {
          data,
          query,
          page: parseInt(page, 10),
        },
      });
    },
    // *remove({ payload: id }, { call, put }) {
    //   yield call(makersService.remove, id);
    //   yield put({ type: 'reload' });
    // },
    *patch({ payload: { id, values } }, { call, put, select }) {
      yield call(makersService.patch, id, values);
      // const page = yield select(state => state.makers.page);
      // yield put({ type: 'fetch', payload: { page } });
    },
    // *create({ payload: values }, { call, put }) {
    //   yield call(makersService.create, values);
    //   yield put({ type: 'reload' });
    // },
    // *reload(action, { put, select }) {
    //   const page = yield select(state => state.makers.page);
    //   yield put({ type: 'fetch', payload: { page } });
    // },
    // *search({ payload: { query, page = 1 } }, { call, put }) {
    //   console.log('*search', query, page);
    //   const { data } = yield call(makersService.search, { query, page });
    //   yield put({
    //     type: 'save',
    //     payload: {
    //       data,
    //       page: parseInt(page, 10),
    //     },
    //   });
    // },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, search }) => {
        if (pathname === '/makers') {
          dispatch({
            type: 'fetch',
            payload: queryString.parse(search),
          });
        }
      });
    },
  },
};
