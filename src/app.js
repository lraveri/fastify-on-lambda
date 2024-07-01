const fastify = require('fastify')

const app = fastify()
app.get('/hello', (request, reply) => {
    reply.send({ message: 'Hello from AWS Lambda' })
})

app.post('/hello', (request, reply) => {
    reply.send({ message: `Hello ${request.body.name} from AWS Lambda`})
})

if (require.main === module) {
    // called directly i.e. "node app"
    app.listen({ port: 3000 }, (err) => {
        if (err) console.error(err)
        console.log('server listening on 3000')
    })
} else {
    // required as a module => executed on aws lambda
    module.exports = app
}