# Hybris notes
- `installer recipes` : can load Accelerators, SAP integrations, Backoffice or a minimal SAP Commerce platform-only configuration
- `ant` : setup env write `. ./setantenv.sh` in `hybris/bin/platform` 
	1. ant initialize - drop all tables and initialize impex
	2. ant updatesystem - update tables which defined in impex
	3. classes - hot update(ant all)
	4. *.xml - ant clean all
	5. *-spring.xml - restart
- `extensions` :
	1. create empty extension `ant extgen -Dinput.template="yempty" -Dinput.name="<extension-name>" -Dinput.package="<package-name>"`
	2. new extension dir must be specified in `localextensions.xml`
- `itemtypes, enumtypes & relations` : write to \*-items.xml
- `*-items.xml` : to store db models
- `*.impex` : db independent
	1. common methods: INSERT, UPDATE, INSERT\_UPDATE, REMOVE
	2. $localvariable = variable, then $localvariable to interpolate
	3. projectdata*.impex - essential for project features
	4. essentialdata*.impex - mandatory data
	5. @translator[class] - provide specific instructions with java class to handle data of this item, class hava access to impex line contents
	6. db data can be exported in zip which includes csv files, then u can import data from backoffice or by impex script which refers to this files 
- `db` : data initialize options:
	1. import & initialize from view
	2. load from `resources/impex` all by convention names `essentialdata*.impex`, `projectdata*.impex` or create java class to customize files to initialize
- `src/testsrc.<extension-name>` in `/hybris/bin/custom/<extension-name>` contain: 
	1. controllers
	2. facades
	3. services
	4. daos
	5. constants
	6. constaints
	7. attributehandlers
	8. events
	9. interceptors
	10. jobs
	11. setup(src only) - system setup & custom one for load specified impex files
- `web/webroot/WEB-INF/views` contain jsp pages
- `resources/` contain:
	1. <extension-name>/media
	2. impex/\*.impex
	3. localization/\*.properties
- `dynamicAttribute` : class that extends `AbstractDynamicAttributeHandler`, write your handler logic inside, add as bean & use in item attribute
- `event` :
	1. can extend:
		1. `AbstractEvent`
		2. `TransactionAwareEvent` with `Executor` to configure async sending
	2. can implement `ClusterAwareEvent` to publish event for specified node
- `event service` : can publish or register events, note that other nodes in cluster handle events async
- `event listener` : can extend:
	1. `AbstractEventListener` & handle events in if blocks with instanceof method
	2. `AbstractEventListener<yourEventName>` to handle specific event
- `interceptors` : need bean with itself & item to listen, types which relies on `ModelService` methods:
	1. Load
	2. Init Defaults
	3. Prepare
	4. Validate
	5. Remove
- `job` : class contain logic which should be performed
- `cronjob` : extends `AbstractJobPerformable<CronJobModel>` & define how to perform job specified
- `trigger` : perform cronjob at specified time or interval
- `localization` : via impex files & in backoffice via \*.properties files
- `back-end validation` : defined in \*-items.xml & impex files or with backoffice
- `media` : map names, locations via impex to interpolate on view
- `*.propeties` : files, the higher overrides another declarations:
	1. local.properties in hybris config dir which override project.properties default config
	2. project.properties in extension dir
	3. project.properties in platform dir
- `configuration service` : allow use values from \*.properties in java classes
