Class {
	#name : #EveryPlayer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
EveryPlayer >> = aPlayer [

	^ aPlayer class = self class
]
