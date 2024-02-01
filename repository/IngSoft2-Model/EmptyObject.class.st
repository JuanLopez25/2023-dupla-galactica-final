Class {
	#name : #EmptyObject,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
EmptyObject >> duplicate [

	^ self class new
]

{ #category : #Information }
EmptyObject >> effect: aPlayer in: aGame [ 


]

{ #category : #information }
EmptyObject >> isEmpty [

	^ true
]
