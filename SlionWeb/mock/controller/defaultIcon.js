const List = require('../../src/data/remixIcons.js')

module.exports = [
    {
        url: '/defaultIcon/getList',
        type: 'get',
        response(config) {
            const { title, pageNo = 1, pageSize = 72 } = config.query
            const mockList = List.filter(
                (item) => !(title && !item.includes(title))
            )
            const list = mockList.filter(
                (item, index) =>
                    index < pageSize * pageNo &&
                    index >= pageSize * (pageNo - 1)
            )
            return {
                code: 200,
                msg: 'success',
                data: { list, ...{ total: mockList.length } },
            }
        },
    },
]
