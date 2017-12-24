import queryString from 'query-string';
import request from '../utils/request';
// import { PAGE_SIZE } from '../constants';

export function fetch({ query, page }) {
  const params = {};
  if (query && query.length > 0) params.query = query;
  if (page > 1) params.page = page;
  const qs = queryString.stringify(params);
  let url = '/api/makers';
  if (qs.length > 0) url += `?${qs}`;
  return request(url);
}

export function patch(id, values) {
  console.log(id, values, JSON.stringify(values));

  return request(`/api/makers/${id}`, {
    method: 'PATCH',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(values),
  });
}

// export function search({ query, page }) {
//   // let url = `/api/makers/search?query=${query}`;
//   // if (page > 0) url += `&page=${page}`;
//   console.log('post/search', query, page);
//   return request(`/api/makers/search?query=${query}&page=${page}`);
// }
