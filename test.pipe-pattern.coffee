chai = require 'chai'
chai.should()
chaiAsPromised = require 'chai-as-promised'
chai.use chaiAsPromised
Q = require 'q'
_ = require 'lodash'
sinon = require 'sinon'

Piper = require './pipe-pattern'
describe "Piper()", ->
    beforeEach ->
        @mod = new Piper {name: 'tushar'}

    describe "_callItems()", ->

        it "value:100", ->
            A =  sinon.spy()
            @mod._callItems 100, A
            .then -> A.calledWith(100).should.be.ok

        it "value:[1,2,3]", ->
            A =  sinon.spy()
            @mod._callItems [1,2,3], A
            .then ->
                A.calledWith(1).should.be.ok
                A.calledWith(2).should.be.ok
                A.calledWith(3).should.be.ok

        it "value:Q([10,20,30])", ->
            A =  sinon.spy()
            @mod._callItems Q([10,20,30]), A
            .then ->
                A.calledWith(10).should.be.ok
                A.calledWith(20).should.be.ok
                A.calledWith(30).should.be.ok

        it "value:[Q(10),Q(20)]", ->
            A =  sinon.spy()
            @mod._callItems [Q(10),Q(20)], A
            .then ->
                A.calledWith(10).should.be.ok
                A.calledWith(20).should.be.ok

        it "value:Q([Q(10),Q(20)])", ->
            A =  sinon.spy()
            @mod._callItems Q([Q(10),Q(20)]), A
            .then ->
                A.calledWith(10).should.be.ok
                A.calledWith(20).should.be.ok