const graphql = require('graphql');
const FoodDepot = require('../models/foodDepot');
const Merchandise = require('../models/merchandise');
const Issue = require('../models/issue');
const Image = require('../models/image');

const {
    GraphQLObjectType,
    GraphQLSchema,
    GraphQLFloat,
    GraphQLString,
    GraphQLID,
    GraphQLInt,
    GraphQLBoolean,
    GraphQLList,
    GraphQLNonNull,
} = graphql;


const FoodDepotType = new GraphQLObjectType({
    name: 'FoodDepot',
    fields: () => ({
        id: { type: GraphQLID },
        name: { type: GraphQLString },
        address: { type: GraphQLString },
        longitude: { type: GraphQLFloat },
        latitude: { type: GraphQLFloat },
        provider: { type: GraphQLString },
        phone: { type: GraphQLString },
        merchandiseList: {
            type: new GraphQLList(MerchandiseType),
            resolve(parent, args) {
                let list = [];
                for (let i=0; i<parent.merchandiseIdList.length; i++) {
                    list.push(Merchandise.findById(parent.merchandiseIdList[i]));
                }
                return list;
            }
        }
    })
});

const MerchandiseType = new GraphQLObjectType({
    name: 'Merchandise',
    fields: () => ({
        id: { type: GraphQLID },
        name: { type: GraphQLString },
        //foodDepots: {} //return all depots which have this type of merchandise
    })
});

const IssueType = new GraphQLObjectType({
    name: 'Issue',
    fields: () => ({
        id: { type: GraphQLID },
        fullName: { type: GraphQLString },
        address: { type: GraphQLString },
        birthDate: { type: GraphQLInt },
        birthMonth: { type: GraphQLInt },
        birthYear: { type: GraphQLInt },
        phone: { type: GraphQLString },
        email: { type: GraphQLString },
        identityNumber: { type: GraphQLString },
        sex: { type: GraphQLString },
        issueType: { type: GraphQLString },
        issueDescription: { type: GraphQLString },
        wellBeing: { type: GraphQLBoolean },
        disability: { type: GraphQLBoolean },
        homelessness: { type: GraphQLBoolean },
        urgency: { type: GraphQLInt },
        images: {
            type: new GraphQLList(ImageType),
            resolve(parent, args) {
                return Image.find({ issueId: parent.id });
            }
        },
        isYourself: { type: GraphQLBoolean },
        createDate: { type: GraphQLInt },
        createMonth: { type: GraphQLInt },
        createYear: { type: GraphQLInt },
        closeDate: { type: GraphQLInt },
        closeMonth: { type: GraphQLInt },
        closeYear : { type: GraphQLInt },
    })
});

const ImageType = new GraphQLObjectType({
    name: 'Image',
    fields: () => ({
        id: { type: GraphQLID },
        url: { type: GraphQLString },
        issue: {
            type: IssueType,
            resolve(parent, args) {
                return Issue.findById(parent.issueId);
            }
        }
    })
});


const RootQuery = new GraphQLObjectType({
    name: 'RootQuery',
    fields: {
        foodDepot: {
            type: FoodDepotType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return FoodDepot.findById(args.id);
            }
        },
        merchandise: {
            type: MerchandiseType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return Merchandise.findById(args.id);
            }
        },
        issue: {
            type: IssueType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return Issue.findById(args.id);
            }
        },
        image: {
            type: ImageType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return Image.findById(args.id);
            }
        },
        foodDepots: {
            type: new GraphQLList(FoodDepotType),
            resolve(parent, args) {
                return FoodDepot.find({});
            }
        },
        merchandiseList: {
            type: new GraphQLList(MerchandiseType),
            resolve(parent, args) {
                return Merchandise.find({});
            }
        },
        issues: {
            type: new GraphQLList(IssueType),
            resolve(parent, args) {
                return Issue.find({});
            }
        },
        images: {
            type: new GraphQLList(ImageType),
            resolve(parent, args) {
                return Image.find({});
            }
        },
    }
});

const Mutation = new GraphQLObjectType({
    name: 'Mutation',
    fields: {
        addFoodDepot: {
            type: FoodDepotType,
            args: {
                name: { type: GraphQLString },
                address: { type: GraphQLString },
                longitude: { type: GraphQLFloat },
                latitude: { type: GraphQLFloat },
                provider: { type: GraphQLString },
                phone: { type: GraphQLString },
                merchandiseIdList: { type: new GraphQLList(GraphQLID) },
            },
            resolve(parent, args) {
                let foodDepot = new FoodDepot({
                    name: args.name,
                    longitude: args.longitude,
                    latitude: args.latitude,
                    provider: args.provider,
                    merchandiseIdList: args.merchandiseIdList,
                });
                return foodDepot.save();
            }
        },
        addMerchandise: {
            type: MerchandiseType,
            args: {
                name: { type: GraphQLString },
            },
            resolve(parent, args) {
                let merchandise = new Merchandise({
                    name: args.name,
                });
                return merchandise.save();
            }
        },
        addIssue: {
            type: IssueType,
            args: {
                fullName: { type: GraphQLString },
                address: { type: GraphQLString },
                birthDate: { type: GraphQLInt },
                birthMonth: { type: GraphQLInt },
                birthYear: { type: GraphQLInt },
                phone: { type: GraphQLString },
                email: { type: GraphQLString },
                identityNumber: { type: GraphQLString },
                sex: { type: GraphQLString },
                issueType: { type: GraphQLString },
                issueDescription: { type: GraphQLString },
                wellBeing: { type: GraphQLBoolean },
                disability: { type: GraphQLBoolean },
                homelessness: { type: GraphQLBoolean },
                urgency: { type: GraphQLInt },
                isYourself: { type: GraphQLBoolean },
                createDate: { type: GraphQLInt },
                createMonth: { type: GraphQLInt },
                createYear: { type: GraphQLInt },
                closeDate: { type: GraphQLInt },
                closeMonth: { type: GraphQLInt },
                closeYear: { type: GraphQLInt },
            },
            resolve(parent, args) {
                let issue = new Issue({
                    fullName: args.fullName,
                    address: args.address,
                    birthDate: args.birthDate,
                    birthMonth: args.birthMonth,
                    birthYear: args.birthYear,
                    phone: args.phone,
                    email: args.email,
                    identityNumber: args.identityNumber,
                    sex: args.sex,
                    issueType: args.issueType,
                    issueDescription: args.issueDescription,
                    wellBeing: args.wellBeing,
                    disability: args.disability,
                    homelessness: args.homelessness,
                    urgency: args.urgency,
                    isYourself: args.isYourself,
                    createDate: args.createDate,
                    createMonth: args.createMonth,
                    createYear: args.createYear,
                    closeDate: args.closeDate,
                    closeMonth: args.closeMonth,
                    closeYear: args.closeYear,
                });
                return issue.save();
            }
        },
        closeIssue: {
            type: IssueType,
            args: {
                id: { type: GraphQLID },
                closeDate: { type: GraphQLInt },
                closeMonth: { type: GraphQLInt },
                closeYear: { type: GraphQLInt },
            },
            resolve(parent, args) {
                let updatedIssue;
                Issue.findById(args.id, (err, doc) => {
                    doc.closeDate = args.closeDate;
                    doc.closeMonth = args.closeMonth;
                    doc.closeYear = args.closeYear;
                    updatedIssue = doc.save();
                });
                return updatedIssue;
            }
        },
        addImage: {
            type: ImageType,
            args: {
                url: { type: GraphQLString },
                issueId: { type: GraphQLID },
            },
            resolve(parent, args) {
                let image = new Image({
                    url: args.url,
                    issueId: args.issueId,
                });
                return image.save();
            }
        },
    }
});

module.exports = new GraphQLSchema({
    query: RootQuery,
    mutation: Mutation,
});